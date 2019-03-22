# encoding: utf-8
module TestServer
  module WebHelper
    def generate_string(count, string = "Plain Data\n")
      string * count.to_i
    end
  
    def generate_random_string(count)
      o = [('a'..'z'), ('A'..'Z'), (1..9), %w{° ^ ! " § $ % & / ( ) = ? * + ~ ` ´ ' # > < | @ ł € ¶ ŧ ← ↓ → ŋ đ ð ſ ð đ ŋ ħ “ „ ¢ « | » « ¢ „ “ ” µ · … – ĸ ¹ ² ³ ¼ ½ ¬ \{ [ ] \}}].map { |i| i.to_a }.flatten

      (0...count.to_i).map { o[rand(o.length)] }.join
    end

    def generate_eicar
      [ 'X', '5', 'O', '!', 'P', '%', '@', 'A', 'P', '[', '4', "\\", 'P',
        'Z', 'X', '5', '4', '(', 'P', '^', ')', '7', 'C', 'C', ')', '7',
        '}', '$', 'E', 'I', 'C', 'A', 'R', '-', 'S', 'T', 'A', 'N', 'D',
        'A', 'R', 'D', '-', 'A', 'N', 'T', 'I', 'V', 'I', 'R', 'U', 'S',
        '-', 'T', 'E', 'S', 'T', '-', 'F', 'I', 'L', 'E', '!', '$', 'H',
        '+', 'H', '*' ]
    end

    def configure_caching
      if params.key? 'expires'
        expires_in params[:expires].to_i, public: true, must_revalidate: true
      else
        expires_now
      end
    end

    def encode(params, &block)
      encoders = []
      encoders << Encoders::Base64.new
      encoders << Encoders::Base64Strict.new
      encoders << Encoders::Gzip.new

      encoders_to_run = params.to_h.symbolize_keys.keep_if {|_,v| v.to_bool == true }.keys & encoders.collect { |e| e.name }

      if encoders_to_run.blank?
        real_encoders = [Encoders::Null.new]
      else
        real_encoders = encoders_to_run.collect { |er| encoders.find { |e| e.name? er } }.compact
      end

      real_encoders.reduce(block.call) do |memo, e| 
        e.encode(memo)
      end
    end
  end
end
