class Rack::Attack
  # Rate limits for Auth endpoints
  throttle('req/ip', limit: 300, period: 5.minutes) do |req|
    req.ip
  end

  throttle('logins/email', limit: 5, period: 20.seconds) do |req|
    if req.path == '/api/v1/auth/login' && req.post?
      req.params['email'].presence || req.params['phone_number'].presence
    end
  end

  throttle('signup/ip', limit: 3, period: 10.minutes) do |req|
    if req.path == '/api/v1/auth/signup' && req.post?
      req.ip
    end
  end

  throttle('otp/ip', limit: 5, period: 5.minutes) do |req|
    if (req.path == '/api/v1/auth/verify-otp' || req.path == '/api/v1/auth/resend-otp') && req.post?
      req.ip
    end
  end

  self.throttled_responder = lambda do |env|
    [ 429, { 'Content-Type' => 'application/json' }, [{ error: "Too many requests. Please try again later." }.to_json] ]
  end
end
