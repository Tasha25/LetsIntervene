 #encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

SchoolSystem.create(name: 'NYCDOE', contact_person: 'Yolanda Smith ', contact_email: 'ysmith@nycdoe.com', street1: ' 100 Lane',city: 'Bx', state: 'NY', zip_code: '11201', phone: '2123456789')
SchoolSystem.create(name: 'Long Island', contact_person: 'Phil Smith ', contact_email: 'psmith@lidoe.com', street1: ' 200 Lane',city: 'Nassau', state: 'NY', zip_code: '10056', phone: '5163456789')


SchoolDistrict.create(name: 'District 10', contact_person: 'Don Lie', school_system_id: '1' )
SchoolDistrict.create(name: 'District 10', contact_person: 'Jon New', school_system_id: '1' )
SchoolDistrict.create(name: 'District 11', contact_person: 'Harry Tall', school_system_id: '2' )


School.create(name:'DWCHS', mission:' sine labore nihil', school_district_id: '2')
School.create(name:'JFK', mission:' we have fun', school_district_id: '3')


User.create(user_name: "ngreen", email: "ngreen@schools.nyc", school_id: '1', service_provider_id: '2', password: '123456', password_confirmation: '123456')
User.create(user_name: "mcollins", email: "mcollins@schools.nyc", school_id: '1', service_provider_id: '2', password: '123456', password_confirmation: '123456')
User.create(user_name: "wclarke", email: "wclarke@schools.nyc", school_id: '2', service_provider_id: '3', password: '123456', password_confirmation: '123456')

Role.create(title: "teacher")
Role.create(title: "parent")
Role.create(title: "social worker")
Role.create(title: "dean")
Role.create(title: "principal")


ServiceCategory.create(name: 'Parent outreach')
ServiceCategory.create(name: 'Intervention by Counseling')
ServiceCategory.create(name: 'Guidance conference')
ServiceCategory.create(name: 'Restorative Approaches')
ServiceCategory.create(name: 'Mentoring Programs')
ServiceCategory.create(name: 'Peer Mediation')

IncidentLog.create( comment: 'Student needs mediation', user_id: '3' , student_id: '1' )
IncidentLog.create( comment: 'Student needs behaviour contract', user_id: '3' , student_id: '2' )
IncidentLog.create( comment: 'love issues, fight with girlfriend', user_id: '2' , student_id: '3' )
IncidentLog.create( comment: 'peer mediation - group', user_id: '1' , student_id: '3' )



ServiceProvider.create( name: 'Hidden Gems Archery' , mission: 'to bring archery to the masses', image_url:'http://www.hiddengemsarchery.com/wp-content/uploads/2013/02/cropped-Screen-Shot-2013-02-12-at-11.45.43-AM-e1360885247611.png',website: 'http://www.hiddengemsarchery.com/', contact_person: 'q', contact_email:'q@hga@aol.com', providers_email: 'info@thehiddengems.com', street1: '180 Remson Street', street2: '', city:'Bronx', state:'NY', zip_code:'10469', work_phone:'254-247-4477', fax:'', infraction_supported:'',other:'')

ServiceProvider.create( name: 'Cardinal McCloskey' , mission: 'Our At-Risk Services’ mission is to promote a safe and nurturing environment for at-risk children and youth and the goal is to keep children safe, prevent abuse and strengthen biological families.', image_url: '', website: 'http://www.cmcs.org/', contact_person: 'cardinal', contact_email:'cardinal@hga@aol.com', providers_email: 'MHess@cmcs.org', street1: '953 Southern Blvd.', street2: 'Room 303', city:'Bronx', state:'NY', zip_code:'10459', work_phone:'718-542-0255', fax:'', infraction_supported:'', other:'')

Student.create(image_url: 'http://api.randomuser.me/0.2/portraits/men/20.jpg', first_name: 'John', last_name: 'Doe', identification_number: '123456789',  date_of_birth: '12/13/99', school_id:'1')
Student.create(image_url: 'http://api.randomuser.me/?seed=goldenFrog',first_name: 'Clarissa', last_name: 'Burke', identification_number: '11122233', date_of_birth: '1/19/98', school_id:'1')
Student.create(image_url: 'http://api.randomuser.me/?seed=smallSnake', first_name: 'Tom', last_name: 'Hanks', identification_number: '237849679', date_of_birth: '2/10/97', school_id:'2')

Parent.create(first_name: 'Harold', last_name: 'Doe', street1: '900 Broadway', work_phone: '234564662', email: 'harold@gmail.com')
Parent.create(first_name: 'Fiona', last_name: 'Taylor', street1: '901 Broadway', work_phone: '12233234', email: 'fiona@gmail.com')
Parent.create(first_name: 'Lizzie', last_name: 'Salt',street1: '902 Broadway', work_phone: '99989888', email:'lizzie@gmail.com')
Parent.create(first_name: 'Tilla', last_name: 'Doe', street1: '903 Broadway', work_phone: '234564662')

referral1 = Referral.create( comment: 'Student needs some help with anger issues', user_id: '4' , student_id: '2' )
referral2 = Referral.create( comment: 'Student needs counseling', user_id: '4' , student_id: '3' )
referral3 = Referral.create( comment: 'gang intervention', user_id: '2' , student_id: '1' )


referral1.service_providers = [ServiceProvider.find_by_id(1)]
referral2.service_providers = [ServiceProvider.find_by_id(2)]
referral3.service_providers = [ServiceProvider.find_by_id(3)]

IncidentLog.create(comment:'Student had fight with another student', student_id:'3', user_id:'1')
IncidentLog.create(comment:'Student had verbal with another student', student_id:'1', user_id:'3')
IncidentLog.create(comment:'Student had tagged up bathroom', student_id:'2', user_id:'4')
IncidentLog.create(comment:'Student invovled in gang activity', student_id:'3', user_id:'4')

DisciplinaryResponse.create(code: 'G', name:'Principal\'s Suspension', description:'This can be 5 days or less')
DisciplinaryResponse.create(code: 'H', name:'Superintendent\'s suspension', description:'This will result in immediate reinstatement')
DisciplinaryResponse.create(code: 'E', name:'Detention', description:'Student comes after school or before school')


GuidanceIntervention.create(name: 'Parent Outreach', description: 'Ask parents to come in ')
GuidanceIntervention.create(name: 'Intervention by Counseling staff', description: 'Talk to student in depth')
GuidanceIntervention.create(name: 'Guidance conference', description: 'A detail conference with support services')
GuidanceIntervention.create(name: 'Positive Behavioral Intervention', description: ' A multi-step approach to reconnect the child')


Infraction.create(code: 'B33', description: 'Engaging in sexual conduct on school premises or at school-related functions')
Infraction.create(code: 'B36', description: 'Engaging in physical aggressive behavior other than minor altercations as described under B24')
Infraction.create(code: 'B40', description: 'Possessing controlled substances or prescription medications without appropriate authorization')



ids = [1, 2, 3]
ids.each do |provider_id|
 service_provider = ServiceProvider.find_by_id(provider_id)
 service_provider.infractions = [Infraction.find_by_id(ids.sample)]
end


ids = [1,2, 3]
ids.each do |infraction_id|
  infraction = Infraction.find_by_id(infraction_id)
  infraction.incident_logs = [IncidentLog.find_by_id(ids.sample)]
end

ids = [1,2,3]
ids.each do |disciplinary_response_id|
  disciplinary_response = DisciplinaryResponse.find_by_id(disciplinary_response_id)
  disciplinary_response.incident_logs = [IncidentLog.find_by_id(ids.sample)]
end

ids = [1,2,3,4]
ids.each do |guidance_intervention_id|
  guidance_intervention = GuidanceIntervention.find_by_id(guidance_intervention_id)
  guidance_intervention.incident_logs = [IncidentLog.find_by_id(ids.sample)]
end

ids = [1,2,3]
ids.each do |service_category_id|
  service_category = ServiceCategory.find_by_id(service_category_id)
  service_category.service_providers = [ServiceProvider.find_by_id(ids.sample)]
end
