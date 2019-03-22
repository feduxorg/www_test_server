# encoding: utf-8
module TestServer
  module SpecHelper
    module Eicar
      def eicar_test_string
        %w{X  5  O  !  P  %  @  A  P  [  4  \\  P  Z  X  5  4  (  P  ^  )  7  C  C  )  7  \}  $  E  I  C  A  R  -  S  T  A  N  D  A  R  D  -  A  N  T  I  V  I  R  U  S  -  T  E  S  T  -  F  I  L  E  !  $  H  +  H  * }.join
      end
    end
  end
end

RSpec.configure do |c|
  c.include TestServer::SpecHelper::Eicar
end

