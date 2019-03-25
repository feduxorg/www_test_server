require 'psych'
require 'i18n'
require 'i18n/backend/fallbacks'
require 'json'
require 'base64'
require 'thor'
require 'zlib'
require 'digest/sha1'
require 'timeout'
require 'filemagic'
require 'securerandom'

require 'active_support/core_ext/kernel/reporting'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/array/access'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/string/inflections'

require 'timeout'
require 'logger'
require 'psych'
require 'addressable/uri'
require 'securerandom'
require 'erb'

require 'test_server/exceptions'

require 'test_server/error_handler'

require 'test_server/encoder'
require 'test_server/encoders/base64_strict'
require 'test_server/encoders/base64'
require 'test_server/encoders/null'
require 'test_server/encoders/gzip'

require 'test_server/version'

require 'test_server/command_runner'
require 'test_server/file_size'
require 'test_server/uploaded_file'
require 'test_server/virus_detector'
require 'test_server/file_permissions_relaxer'
require 'test_server/filetype_detector'
require 'test_server/checksum'
require 'test_server/checksum_calculator'
require 'test_server/sha256_calculator'
require 'test_server/md5_calculator'
require 'test_server/file_deleter'

require 'test_server/web_helper'

require 'test_server/config'

module TestServer; end
