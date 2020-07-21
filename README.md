# Covid19
## What is it?
A [Smalltalk (Cuis)](https://github.com/Cuis-Smalltalk/Cuis-Smalltalk-Dev) client for https://covid19api.com/

## Running
After cloning this repository, open a workspace in Cuis and type:

```Smalltalk 
Feature require: #Covid19. 
```

And then:

```Smalltalk
|client|
client := Covid19ApiClient  new.

client getWorldTotal. 

client getFromDayOneByCountry: 'Brazil'. 

client getCountries. 

```
