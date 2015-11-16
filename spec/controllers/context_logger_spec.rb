# require 'spec_helper'
# require 'rails/all'
#
# require 'rspec/rails'
#
# require './app/controllers/api/v1/resources/context_logger_controller.rb'
#
# describe Api::V1::Resources::ContextLoggerController do
#   let (:connection) { mock("connection") }
#   before(:each) do
#     ::ActiveRecord::Base.stub!(:connection).and_return(connection)
#     ConnectionPool.any_instance.stub(:retrieve_connection).and_return({lala: 1})
#   end
#
#   context 'index' do
#     it 'ContextLoggerController' do
#       response_body = 'response_body'
#
#       get :index
#       expect(response.body).to eq(response_body)
#     end
#   end
# end
