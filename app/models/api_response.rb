class ApiResponse
    attr_reader :raw
    delegate :status, :headers, :body, to: :raw

    def initialize(raw_resp)
        @raw = raw_resp
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
end