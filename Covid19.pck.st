'From Cuis 5.0 [latest update: #4254] on 21 July 2020 at 4:08:35 pm'!
'Description A cuis client for https://covid19api.com/'!
!provides: 'Covid19' 1 1!
!requires: 'WebClient' 1 19 nil!
SystemOrganization addCategory: #'Covid19-ApiClient'!


!classDefinition: #Covid19ApiClientTest category: #'Covid19-ApiClient'!
TestCase subclass: #Covid19ApiClientTest
	instanceVariableNames: 'client'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Covid19-ApiClient'!
!classDefinition: 'Covid19ApiClientTest class' category: #'Covid19-ApiClient'!
Covid19ApiClientTest class
	instanceVariableNames: ''!

!classDefinition: #Covid19ApiClient category: #'Covid19-ApiClient'!
Object subclass: #Covid19ApiClient
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Covid19-ApiClient'!
!classDefinition: 'Covid19ApiClient class' category: #'Covid19-ApiClient'!
Covid19ApiClient class
	instanceVariableNames: ''!


!Covid19ApiClientTest methodsFor: 'setUp/tearDown' stamp: 'TSL 7/21/2020 14:17:36'!
setUp
	client := Covid19ApiClient new.! !

!Covid19ApiClientTest methodsFor: 'setUp/tearDown' stamp: 'TSL 7/21/2020 14:17:48'!
tearDown
	client := nil.! !

!Covid19ApiClientTest methodsFor: 'tests' stamp: 'TSL 7/21/2020 15:02:25'!
testGetCountries
	| response |
	response := client getCountries.
	self assert: response isNil not. 
	self assert: (response size > 0) . 
	self assert: ((response at: 1)  includesKey: 'Country' ). 
! !

!Covid19ApiClientTest methodsFor: 'tests' stamp: 'TSL 7/21/2020 15:04:51'!
testGetFromDayOneByCountry
	| response |
	response := client getFromDayOneByCountry: 'Brazil'.
	self assert: response isNil not. 
	self assert: (response size > 0). 
	self assert: ((response at: 1)  includesKey: 'Confirmed'). 
	self assert: ((response at: 1)  includesKey: 'Recovered'). 
	self assert: ((response at: 1)  includesKey: 'Deaths'). 
	self assert: ((response at: 1)  includesKey: 'Country'). 
	self assert: ((response at: 1)  at: 'Country') = 'Brazil'. 
! !

!Covid19ApiClientTest methodsFor: 'tests' stamp: 'TSL 7/21/2020 14:30:23'!
testGetWorlTotal
	| response |
	response := client getWorldTotal.
	self assert: response isNil not. 
	self assert: (response includesKey: 'TotalConfirmed') . 
	self assert: (response includesKey: 'TotalDeaths') . 
	self assert: (response includesKey: 'TotalRecovered') . 
! !

!Covid19ApiClient methodsFor: 'private' stamp: 'TSL 7/21/2020 13:26:22'!
executeRequest: enpoint
	| response |
	response := (WebClient httpGet: Covid19ApiClient url, enpoint) .

	(response code ~= 200)
		ifTrue: [ self error: 'No data' ].

	^ WebUtils jsonDecode: (response content readStream).! !

!Covid19ApiClient methodsFor: 'queries' stamp: 'TSL 7/21/2020 13:27:22'!
getCountries
	^ self executeRequest:  '/countries'.! !

!Covid19ApiClient methodsFor: 'queries' stamp: 'TSL 7/21/2020 13:27:30'!
getFromDayOneByCountry: aCountryName
	^ self executeRequest:  '/total/dayone/country/',aCountryName.! !

!Covid19ApiClient methodsFor: 'queries' stamp: 'TSL 7/21/2020 13:26:58'!
getWorldTotal
	^ self executeRequest:  '/world/total'.! !

!Covid19ApiClient class methodsFor: 'accessing' stamp: 'TSL 7/21/2020 13:25:45'!
url
	^ 'https://api.covid19api.com'! !
