### flambé server environment

This is the server component of flambé, powered by NodeJs, Express, MongoDB and Coffeescipt.
In development, this enviroment should include latest front-end elements from the ui directory.

#### Core development should take place in the src/ directory.
#### /src/coffee/lib/setup should be edited as appropriate to utilize the correct DB to use

### Testing
Tests are run via:

```
	$ mocha
```
**note:** running test will in fact delete **all** users in the database


Alvaro Muir, @alvaromuir
