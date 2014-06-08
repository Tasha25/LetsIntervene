##LetsIntervene

TBA

###Setup

1. Download and install [ImageMagick](http://www.imagemagick.org/)
2. Run "bundle"
3. Initial database setup 
		- run 'psql' *(to get into psql)*
		- run 'create database letsintervene' *(to create psql database)*
		- run '\q' *(exit psql)*
4. Go to setup.rb and uncomment the following lines: 
		- CreateServiceProvider.up
		- CreateServiceCategory.up
		- JoinTableServiceCategoriesServiceProviders.up
		- User.up
5. Run 'ruby setup.rb'
6. Go to 'localhost:4567'


###General wireframe

![alt letsinterveneframes](http://i60.tinypic.com/11cf7e8.jpg "LetsInterveneFrames")


