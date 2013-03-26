require 'spec_helper'

describe Contribution do 
  let (:entry) { 'potpie' }
  let (:definition) { 'pastry-covered meat and veggies cooked in a deep dish.' }
  let (:params) { { :entry => entry, :definition => definition, :id => 1 } }
  let (:valid_contribution) { Contribution.new(params) }
  
  context '#initialize' do
    it 'creates an instance of Contribution with an argument (hash)' do
      valid_contribution.should be_an_instance_of Contribution
    end
  end

  context 'readers' do
    it 'returns the entry with #entry' do
      valid_contribution.entry.should eq entry
    end
    it 'returns the definition with #definition' do
      valid_contribution.definition.should eq definition
    end
    it 'returns the id with #id' do
      valid_contribution.id.should eq 1
    end
  end

  context '#create' do
    it 'POSTs a contribution to the Wictionary' do
      contribution = valid_contribution
      stub = stub_request(:post, "#{HOSTNAME}/words/")
      contribution.create
      stub.should have_been_requested
    end
  end

  context '#delete' do
    it 'DELETEs a contribution from the Wictionary' do
      contribution = valid_contribution
      stub = stub_request(:delete, "http://localhost:3000/")
      Contribution.delete(entry)
      stub.should have_been_requested
    end
  end

  context '#search' do
    it 'GETs a requested contribution' do
      contribution = valid_contribution
      stub = stub_request(:get, "http://localhost:3000/")
      Contribution.search(entry)
      stub.should have_been_requested
    end
  end

  context '#update' do
    it 'POSTs a contribution to the Wictionary' do
      contribution = valid_contribution
      stub = stub_request(:put, HOSTNAME)
      contribution.update
      stub.should have_been_requested
    end
  end

  context '.list' do
    it 'GETs all contributions' do
      contribution = valid_contribution
      stub = stub_request(:get, "http://localhost:3000/words/").
         to_return(:status => 200, :body => VALID_LIST_RESPONSE, :headers => {})
      Contribution.list
      stub.should have_been_requested
    end

    it 'returns an array of contribution objects' do
      stub = stub_request(:get, "http://localhost:3000/words/").
         to_return(:status => 200, :body => VALID_LIST_RESPONSE, :headers => {})
      wordlist = Contribution.list
      wordlist.map {|word| word.entry}.should eq ['potpie', 'lizard', 'gatorade']
    end
  end
end