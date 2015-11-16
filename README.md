# context_logger
## Setup
In your Gemfile add:
```
gem 'context_logger'
```
## Setting destinations
In your config file (e.g. config/environment.rb) add
```
ContextLogger.set_destinations(:all)
```
To configure logging distination replace :all with any subset of:
```
{
write_rails_log: true,
write_context_log: true,
write_db_log: true
}
```
e.g. if you want to exclude logging to DB:
```
ContextLogger.set_destinations({
write_rails_log: true,
write_context_log: true
})
```
## Setting up the options (default values)
Instead of passing the values that don't change often (e.g. server, ), it's possible to set them using setup method:  
```
ContextLogger.setup({context: :publish, action_id: 1, server: 'myserver.com'})
```
It's possible to overid them anytime.
To see current value of options, just call:
```
ContextLogger.options
```
## Logging
ContextLogger exposes the following methods for logging:
:info, :warn, :error, :debug, :fatal
And here are the params (with defaults):
```
message, method, params, stack_trace=nil, action_id=nil, context=nil ,server=nil
```
An example of logging a warning message:
```
ContextLogger.warn('Just another message', :store_data, {data:{a:1, b:2}}, "'Range.detach' is now a no-op, as per DOM (http://dom.spec.whatwg.org/#dom-range-detach).", 1)
```
## HTTP API:
In order to write the log also to db_log, you should set it using set_destination method:
```
ContextLogger.set_destinations({
...
write_db_log: true,
...
})
```
The log entries from the DB are available via HTTP API:
http://<server_name>/api/v1/resources/context_logger
