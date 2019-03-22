# encoding: utf-8
require 'spec_helper'

describe PermittedParams do
  context '#initialize' do

  end

  context '#params_for_controller' do
    it 'raises an error on unknown controller' do
      params = ActionController::Parameters.new({})
      permitted_params = PermittedParams.new(params)

      expect {
        permitted_params.params_for_controller("asdfasdf", "show", {})
      }.to raise_error Exceptions::ControllerNotDefinedInParameterList
    end

    it 'raises an error on unknown action' do
      params = ActionController::Parameters.new({})
      permitted_params = PermittedParams.new(params)

      expect {
        permitted_params.params_for_controller("string", "asdf", {})
      }.to raise_error Exceptions::ActionNotDefinedInParameterList
    end

    it 'defines parameters for controllers' do
      params = ActionController::Parameters.new(count: 100)
      permitted_params = PermittedParams.new(params)

      params = permitted_params.params_for_controller("string", "plain", {})
      expect(params[:count]).to eq 100
    end
  end

  context '#known_params_for_controller' do
    it 'raises an error on unknown controller' do
      params = ActionController::Parameters.new({})
      permitted_params = PermittedParams.new(params)

      expect {
        permitted_params.known_params_for_controller("asdfasdf", "show")
      }.to raise_error Exceptions::ControllerNotDefinedInParameterList
    end

    it 'raises an error on unknown action' do
      params = ActionController::Parameters.new({})
      permitted_params = PermittedParams.new(params)

      expect {
        permitted_params.known_params_for_controller("string", "asdf")
      }.to raise_error Exceptions::ActionNotDefinedInParameterList
    end

    it 'returns known parameters for controllers' do
      params = ActionController::Parameters.new(count: 100)
      permitted_params = PermittedParams.new(params)

      params = permitted_params.known_params_for_controller("string", "plain")
      expect(params).to eq [:base64, :base64_strict, :count, :expires, :gzip, :wait]
    end
  end
end
