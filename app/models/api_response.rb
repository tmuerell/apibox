class ApiResponse
    attr_reader :raw, :raw_request, :request_identifier
    delegate :status, :headers, :body, to: :raw

    def initialize(request_identifier, raw_request, raw_response)
        @request_identifier = request_identifier
        @raw_request = raw_request
        @raw = raw_response
    end

    def success?
        @raw.status < 400
    end

    def resp_class
        success? ? 'success' : 'danger'
    end

    def lang
        ct = @raw.headers["Content-Type"]
        if ct =~ /application\/json/
            "json"
        elsif ct =~ /text\/html/
            "html"
        else
            ""
        end
    end

    def pretty_body
        if lang == "json"
            obj = JSON.parse(body)
            JSON.pretty_unparse(obj)
        else
            body
        end
    end
end