#Object
class Object
    def deep_symbolize_keys
        self
    end
end

class Hash
    def deep_symbolize_keys
        symbolize_keys.tap { |h| h.each { |k, v| h[k] = v.deep_symbolize_keys } }
    end
end


#Array
class Array
    def deep_symbolize_keys
        map(&:deep_symbolize_keys)
    end
end

