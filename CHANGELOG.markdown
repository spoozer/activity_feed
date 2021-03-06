# CHANGELOG

## 2.1.0 (2012-08-13)

* Added `full_feed(user_id, aggregate = ActivityFeed.aggregate)` method to be able to retrieve an entire activity feed

## 2.0.0 (2012-06-29)

* Rewrite of the activity_feed gem
* Simplifies namespace in Redis
* Simplifies code to manipulate items and feeds
* Removes explicit ORM/ODM support and delegates that to `item_loader` if necessary
* Adds internal code documentation

## 1.4.0

* Added support for [Mongoid](http://www.mongoid.org)

## 1.3.0

* `ActivityFeed.update_item(user_id, item_id, timestamp, aggregate = false)` allows for updating an activity feed item in the personal or aggregate feed
* `ActivityFeed.delete_item(user_id, item_id, aggregate = false)` allows for removing an activity feed item from the personal or aggregate feed

## 1.2.2

* `ActivityFeed.create_item(attributes, aggregate)` can take an array of user_ids as its 2nd parameter if you want to fan out to the aggregation on create

## 1.2.1

* `ActivityFeed.feed(user_id)` will now return an instance of ActivityFeed::Feed
* `ActivityFeed::Ohm::Item` will now return all of its attributes when calling `to_json`

## 1.2

* Support aggregate feeds

## 1.1.1

* Removing activemodel dependency since that is not needed

## 1.1.0

* Added support for Ohm persistence, http://ohm.keyvalue.org
* Updated specs

## 1.0.0

* Initial release
