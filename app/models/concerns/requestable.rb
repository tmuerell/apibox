module Requestable
  extend ActiveSupport::Concern

  def generate_curl
    rid = SecureRandom.uuid
    query_string = request_params.select { |p| p.id }.map { |p| "#{CGI.escape(p.name)}=#{CGI.escape(dynamic_values(rid, p.value))}" }.join("&")

    lines = []
    res = "curl -H #{method.to_s.upcase} "
    res << url
    res << (query_string.present? ? "?#{query_string}" : "")
    lines << res

    for h in request_headers.select { |p| p.id }
      lines << "  -H \"#{h.name}: #{dynamic_values(rid, h.value)}\""
    end

    if method.post?
      lines << "  -H \"Content-Type: #{content_type}\""
      lines << "  --data '#{body}'"
    end

    lines.join(" \\\n")
  end

  def generate_xh
    rid = SecureRandom.uuid
    query_string = request_params.select { |p| p.id }.map { |p| "#{CGI.escape(p.name)}=#{CGI.escape(dynamic_values(rid, p.value))}" }.join("&")

    lines = []
    res = "xh #{method.to_s.upcase} "
    res << url
    for p in request_params.select { |p| p.id }
      res << " \"#{p.name}==#{dynamic_values(rid, p.value)}\""
    end
    lines << res

    for h in request_headers.select { |p| p.id }
      lines << "  \"#{h.name}: #{dynamic_values(rid, h.value)}\""
    end

    if method.post?
      lines << "  \"Content-Type: #{content_type}\""
      lines << "  --raw '#{body}'"
    end

    lines.join(" \\\n")
  end

  def send_request
    request_identifier = SecureRandom.uuid
    options = {
      request: {
        timeout: 20,
        open_timeout: 20
      }
    }
    if certificate.present?
      cert = OpenSSL::X509::Certificate.new(certificate.cert)
      key = OpenSSL::PKey::RSA.new(certificate.key)
      options.merge!(:ssl => {
        :client_cert => cert,
        :client_key => key,
        :verify => false
      })
    end
    f = Faraday.new(url, options)

    headers = { "User-Agent": "APIBox v0.0.1" }
    unless method.get? || method.delete?
      headers["Content-Type"] = content_type
    end
    for h in all_request_headers
      headers[h.name] = dynamic_values(request_identifier, h.value)
    end
    local_params = {}
    for p in all_request_params
      if local_params[p.name]
        if !local_params[p.name].kind_of?(Array)
          local_params[p.name] = [local_params[p.name]]
        end
        local_params[p.name] << dynamic_values(request_identifier, p.value)
      else
        local_params[p.name] = dynamic_values(request_identifier, p.value)
      end
    end

    raw_request = {
      url: url,
      headers: headers,
      params: local_params
    }

    begin
      if method.get?
        resp = f.get(url, local_params, headers)
      elsif method.post?
        raw_request[:body] = body
        resp = f.post(
          url,
          body,
          headers)
      elsif method.put?
        raw_request[:body] = body
        resp = f.put(
          url,
          body,
          headers)
      elsif method.patch?
        raw_request[:body] = body
        resp = f.patch(
          url,
          body,
          headers)
      else
        raise "Invalid method #{method}"
      end
    rescue Object => o
      response = {
        status: -1,
        error: o.to_json
      }
      return ApiResponse.new(request_identifier, raw_request, response)
    end

    ApiResponse.new(request_identifier, raw_request, resp)
  end

  def dynamic_values(request_identifier, v)
    if v =~ /^\$UUID$/
      SecureRandom.uuid
    elsif v =~ /^\$RID$/
      request_identifier
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