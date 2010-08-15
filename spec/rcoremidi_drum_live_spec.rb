require 'spec_helper'

describe LiveMIDI do
  before(:all) do
    @live = LiveMIDI.new(:client_name      => "rspec", 
                         :logging          => false, 
                         :midi_destination => 0,
                         :client           =>  { :class   => RCoreMidi::Client, :options => "CRAZY RSPEC DOING ELECTRONIC MUSIC" })
  end
  
  it "should instanciate have a client" do
    @live.client.should be_instance_of RCoreMidi::Client
  end
  
end