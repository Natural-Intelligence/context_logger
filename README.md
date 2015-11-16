# context_logger
## Setup
In your Gemfile add:
```
gem 'context_logger'
```
## Usage
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
