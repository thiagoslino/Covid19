'From Cuis 5.0 [latest update: #4528] on 8 February 2021 at 3:28:10 pm'!
'Description A cuis client for disease.sh covid-19 api'!
!provides: 'Covid19' 1 3!
!requires: 'WebClient' 1 20 nil!
SystemOrganization addCategory: 'Covid19-ApiClient'!


!classDefinition: #Covid19ApiClientTest category: 'Covid19-ApiClient'!
TestCase subclass: #Covid19ApiClientTest
	instanceVariableNames: 'client'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Covid19-ApiClient'!
!classDefinition: 'Covid19ApiClientTest class' category: 'Covid19-ApiClient'!
Covid19ApiClientTest class
	instanceVariableNames: ''!

!classDefinition: #Covid19ApiClient category: 'Covid19-ApiClient'!
Object subclass: #Covid19ApiClient
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Covid19-ApiClient'!
!classDefinition: 'Covid19ApiClient class' category: 'Covid19-ApiClient'!
Covid19ApiClient class
	instanceVariableNames: ''!


!Covid19ApiClientTest methodsFor: 'setUp/tearDown' stamp: 'tsl 2/8/2021 15:27:43'!
setUp
	client _ Covid19ApiClient new.! !

!Covid19ApiClientTest methodsFor: 'setUp/tearDown' stamp: 'tsl 2/8/2021 15:27:48'!
tearDown
	client _ nil.! !

!Covid19ApiClientTest methodsFor: 'tests' stamp: 'tsl 2/8/2021 15:27:08'!
testGetCountries
	| response |
	response _ client getCountries.
	self assert: response isNil not. 
	self assert: (response size > 0). 
	
! !

!Covid19ApiClientTest methodsFor: 'tests' stamp: 'tsl 2/8/2021 15:27:03'!
testGetHistoricalByCountry
	| response |
	response _ client getHistoricalByCountry: 'Brazil'.
	self assert: response isNil not. 
	self assert: (response size > 0). 
	self assert: (response at: 'country') = 'Brazil'. 
	self assert: ((response at: 'timeline')  includesKey: 'cases'). 
	self assert: ((response at: 'timeline')  includesKey: 'recovered'). 
	self assert: ((response at: 'timeline')  includesKey: 'deaths'). 
	
! !

!Covid19ApiClientTest methodsFor: 'tests' stamp: 'tsl 2/8/2021 15:27:14'!
testGetWorlTotal
	| response |
	response _ client getWorldTotal.
	self assert: response isNil not. 
	self assert: (response includesKey: 'cases') . 
	self assert: (response includesKey: 'deaths') . 
	self assert: (response includesKey: 'recovered') . 
! !

!Covid19ApiClient methodsFor: 'private' stamp: 'tsl 2/8/2021 15:27:20'!
executeRequest: endpoint
	| response |
	response _ (WebClient httpGet: Covid19ApiClient url, endpoint) .

	(response code ~= 200)
		ifTrue: [ self error: 'No data' ].

	^ WebUtils jsonDecode: (response content readStream).! !

!Covid19ApiClient methodsFor: 'queries' stamp: 'tsl 2/8/2021 14:37:31'!
getCountries
	^ (self executeRequest:  '/countries') collect: [ :each | each at: 'country'].! !

!Covid19ApiClient methodsFor: 'queries' stamp: 'tsl 2/8/2021 14:37:41'!
getHistoricalByCountry: aCountryName
	^ self executeRequest:  '/historical/',aCountryName,'?lastdays=all'.! !

!Covid19ApiClient methodsFor: 'queries' stamp: 'tsl 2/8/2021 14:37:56'!
getWorldTotal
	^ self executeRequest:  '/all'.! !

!Covid19ApiClient class methodsFor: 'accessing' stamp: 'tsl 2/8/2021 14:37:05'!
url
	^ 'https://disease.sh/v3/covid-19'! !
