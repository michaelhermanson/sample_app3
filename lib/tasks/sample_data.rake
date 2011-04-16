require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "michaelhermanson",
                 :email => "michaelhermanson5555@yahoo.com",
                 :password => "herbstar",
                 :password_confirmation => "herbstar")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
     User.all(:limit => 6).each do |user|
      50.times do
       user.microposts.create!(:content => Faker::Lorem.sentence(5))
      end
    end
  end
end
end
