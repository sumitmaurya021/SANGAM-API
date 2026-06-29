module Api
  module V1
    module Auth
      class TotpController < ApplicationController
        before_action :authenticate_request!

        def enable
          if @current_user.two_factor_enabled?
            return render_error(message: '2FA is already enabled', status: :bad_request)
          end

          # Generate secret if not present
          @current_user.update(otp_secret: ROTP::Base32.random) if @current_user.otp_secret.blank?

          totp = ROTP::TOTP.new(@current_user.otp_secret, issuer: 'Sangam')
          provisioning_uri = totp.provisioning_uri(@current_user.email)

          render_success(
            message: '2FA setup initiated',
            data: {
              otp_secret: @current_user.otp_secret,
              provisioning_uri: provisioning_uri
            }
          )
        end

        def confirm
          code = params[:code].to_s.strip.gsub(/\s/, '')
          if code.blank?
            return render_error(message: 'Code is required', status: :bad_request)
          end

          totp = ROTP::TOTP.new(@current_user.otp_secret, issuer: 'Sangam')
          if totp.verify(code, drift_behind: 30)
            @current_user.update(otp_enabled: true)
            render_success(message: '2FA enabled successfully')
          else
            render_error(message: 'Invalid code', status: :unauthorized)
          end
        end

        def disable
          unless @current_user.two_factor_enabled?
            return render_error(message: '2FA is not enabled', status: :bad_request)
          end

          code = params[:code].to_s.strip.gsub(/\s/, '')
          totp = ROTP::TOTP.new(@current_user.otp_secret, issuer: 'Sangam')
          
          if totp.verify(code, drift_behind: 30)
            @current_user.update(otp_enabled: false, otp_secret: nil)
            render_success(message: '2FA disabled successfully')
          else
            render_error(message: 'Invalid code', status: :unauthorized)
          end
        end
      end
    end
  end
end
