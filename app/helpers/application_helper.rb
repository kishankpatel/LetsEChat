module ApplicationHelper
    def encode_id id
        hashids = Hashids.new("let's e-chat with your friend", 16)
        hashids.encode_hex(id.to_s)
    end
    def encode_group_id id
        hashids = Hashids.new("let's e-chat with group", 16)
        hashids.encode_hex(id.to_s)
    end
    def decode_id id
        hashids = Hashids.new("let's e-chat with your friend", 16)
        hashids.decode_hex(id)
    end

end
