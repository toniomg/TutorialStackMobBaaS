<h2>StackMob iOS SDK Change Log</h2>

<h3>v1.1.2 - Oct 29, 2012</h3>

**Features**

* Updated SMQuery Geopoint method to take distance in kilometers instead of meters.  New method is _where:isWithin:kilometersOf:_.
* Add _optionsWithExpandDepth:_ and _optionsWithReturnedFieldsRestrictedTo:_ methods to SMRequestOptions class. 
* Provide error message when creating an object with null values for fields.  If you receive an error which states that a field was sent with a value of null and the type cannot be inferred, simply go online to the Manage Schemas section of your StackMob Dashboard and manually add the field with correct data type.  This happens occasionally when working with number types in Core Data.

**Fixes**

* Allow setting of Core Data relationships to nil.
* Add proper SMRequestOptions headers dictionary initialization.   
* Change default merge policy of SMCoreDataStore _managedObjectContext_ property to NSMergeByPropertyObjectTrumpMergePolicy.  This translates to "client wins" when there are conflicts for particular objects.  Feel free to change the merge policy at any time by calling the _setMergePolicy:_ method on the managed object context of your SMCoreDataStore instance.

<h3>v1.1.1 - Oct 24, 2012</h3>

**Features**

* Full support for Core Data Boolean Data Types.  A Core Data Boolean attribute will map to a Boolean field on StackMob.
* Removal of 'sm_' prefix for NSManagedObject category helper methods.  Use [managedObject assignObjectId] and [managedObject primaryKeyField].
* Update SMClient user schema field property names. **userPrimaryKeyField** and **userPasswordField** describe the primary key and password field names for the user schema, respectively.

**Fixes**

* Update fetch request algorithm to support SMUserManagedObject change.
* Update Core Data object serialization algorithm.  Serialized dictionary sent in request now includes only fields which have been updated since insert or the last call to save.
* Update SMRequestOptions for proper headers dictionary initialization.

<h3>v1.1.0 - Oct 17, 2012</h3>

**Features**

* Removal of SMModel Protocol.  
* Addition of SMUserManagedObject. Your managed object subclass corresponding to user objects should inherit from this class.  SMUserManagedObject provides methods to securely set passwords for user objects without storing them in Core Data attributes. For all the information on how to update your current code [see this blogpost](http://blog.stackmob.com/?p=3547).
* Built for armv7 and armv7s architectures.

<h3>v1.0.1 - Oct 1, 2012</h3>

**Features**

* Can query whether fields are or are not nil. Thanks to combinatorial for the pull request.

**Fixes**

* Address error in serialization algorithm for one-to-one relationship camel cased attributes.
* Address error in request sent when reading from schemas with permissions set.

<h3>v1.0.0 - Sep 26, 2012</h3>

**Features**

* Support for iOS preferred camelCase Core Data property names.
* Support non case-sensitive schema names in datastore API.
* Support Core Data Date attribute type.
* API version and public key provided to SMClient during initialization must be correct format and non-nil.
* Core Data integration debug logging available by setting SM\_CORE\_DATA\_DEBUG = YES. See the Debugging section on the main page of the iOS SDK Reference for more info.

**Fixes**

* Edits to dictionary serialization algorithms for improved performance.
* NewValueForRelationship incremental store method correctly returns empty array for to-many with no objects.

<h3>v1.0.0beta.3 - Aug 24, 2012</h3>

**Fixes** 

* The method save: to the managed object context will return NO if StackMob calls fail.
* Fetch requests not returning errors.

<h3>v1.0.0beta.2 - Aug 20, 2012</h3>

**Features**

* Performing custom code methods is now available through the `SMCustomCodeRequest` class.
* Binary Data can be converted into an NSString using the `SMBinaryDataConversion` class and persisted to a StackMob field with Binary Data type.


<h3>v1.0.0beta.1 - Aug 10, 2012</h3>

**Features**

* Initial release of new and improved iOS SDK.  Core Data integration serves as the biggest change to the way developers interact with the SDK. See [iOS SDK v1.0 beta](https://www.stackmob.com/devcenter/docs/iOS-SDK-v1.0-beta) for more information.