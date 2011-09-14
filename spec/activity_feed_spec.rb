require 'spec_helper'

describe ActivityFeed do
  it 'should have defaults set for :namespace and :key' do
    ActivityFeed.namespace.should eql('activity')
    ActivityFeed.key.should eql('feed')
    ActivityFeed.persistence = :memory
    ActivityFeed.persistence.should be(ActivityFeed::MemoryItem)
  end
  
  describe 'creating' do
    it 'should allow you to create a new item using :memory' do
      user_id = 1
      ActivityFeed.persistence = :memory
      
      ActivityFeed.redis.zcard("#{ActivityFeed.namespace}:#{ActivityFeed.key}:#{user_id}").should be(0)
      ActivityFeed.create_item(:user_id => user_id, :text => 'This is text for my activity feed')
      ActivityFeed.redis.zcard("#{ActivityFeed.namespace}:#{ActivityFeed.key}:#{user_id}").should be(1)      
    end
    
    it 'should allow you to create a new item using :mongo_mapper' do
      user_id = 1
      ActivityFeed.persistence = :mongo_mapper
      
      ActivityFeed::MongoMapperItem.count.should be(0)
      ActivityFeed.redis.zcard("#{ActivityFeed.namespace}:#{ActivityFeed.key}:#{user_id}").should be(0)
      ActivityFeed.create_item(:user_id => user_id, :text => 'This is text for my activity feed')
      ActivityFeed.redis.zcard("#{ActivityFeed.namespace}:#{ActivityFeed.key}:#{user_id}").should be(1)      
      ActivityFeed::MongoMapperItem.count.should be(1)
    end

    it 'should allow you to create a new item using :active_record' do
      user_id = 1
      ActivityFeed.persistence = :active_record
      
      ActivityFeed::ActiveRecordItem.count.should be(0)
      ActivityFeed.redis.zcard("#{ActivityFeed.namespace}:#{ActivityFeed.key}:#{user_id}").should be(0)
      ActivityFeed.create_item(:user_id => user_id, :text => 'This is text for my activity feed')
      ActivityFeed.redis.zcard("#{ActivityFeed.namespace}:#{ActivityFeed.key}:#{user_id}").should be(1)      
      ActivityFeed::ActiveRecordItem.count.should be(1)
    end
  end
  
  describe 'loading' do
    it 'should allow you to load an item using :memory' do
      user_id = 1
      ActivityFeed.persistence = :memory
      
      item = ActivityFeed.create_item(:user_id => user_id, :text => 'This is text for my activity feed')
      loaded_item = ActivityFeed.load_item(item.to_json)
      loaded_item.should == JSON.parse(item.to_json)
    end
    
    it 'should allow you to load an item using :mongo_mapper' do
      user_id = 1
      ActivityFeed.persistence = :mongo_mapper
      
      item = ActivityFeed.create_item(:user_id => user_id, :text => 'This is text for my activity feed')
      loaded_item = ActivityFeed.load_item(item.id)
      loaded_item.should == item
    end

    it 'should allow you to load an item using :active_record' do
      user_id = 1
      ActivityFeed.persistence = :active_record
      
      item = ActivityFeed.create_item(:user_id => user_id, :text => 'This is text for my activity feed')
      loaded_item = ActivityFeed.load_item(item.id)
      loaded_item.should == item
    end
  end
end