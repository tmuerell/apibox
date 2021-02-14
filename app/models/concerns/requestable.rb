module Requestable
    extend ActiveSupport::Concern

    def send_request
      f = if certificate.present?
          cert = OpenSSL::X509::Certificate.new(certificate.cert)
          key = OpenSSL::PKey::RSA.new(certificate.key)
          Faraday.new url, :ssl => {
            :client_cert  => cert,
            :client_key   => key,
            :verify       => false
          }
        else
          Faraday.new url
        end
      
      headers = { "User-Agent": "APIBox v0.0.1", "Content-Type" => content_type }
      for h in all_request_headers
        headers[h.name] = dynamic_values(h.value)
      end
      local_params = {}
      for p in all_request_params
        if local_params[p.name]
          if !local_params[p.name].kind_of?(Array)
            local_params[p.name] = [ local_params[p.name] ]
          end
          local_params[p.name] << dynamic_values(p.value)
        else
          local_params[p.name] = dynamic_values(p.value)
        end
      end
      
      if method.get?
        resp = f.get(url, local_params, headers)
      elsif method.post?
        resp = f.post(
          url,
          body,
          headers)
      elsif method.put?
        resp = f.put(
          url,
          body,
          headers)
      elsif method.patch?
        resp = f.patch(
          url,
          body,
          headers)
      else
        raise "Invalid method #{method}"
      end

      ApiResponse.new(resp)
    end

    def dynamic_values(v)
      if v =~ /^\$UUID$/
        SecureRandom.uuid
      elsif v =~ /^\$NOW$/
        DateTime.now.iso8601
      else
        v
      end
    end

    def lang
      if content_type =~ /application\/json/
        "json"
      else
        ""
      end
    end
end