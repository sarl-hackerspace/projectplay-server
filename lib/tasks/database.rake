require 'csv'
require 'rake'

namespace :db do
    desc "Custom Rake task to remap data"
    task :datarefresh => :environment do
        # Update fields in Playgrounds table for new data
        CSV.foreach (Rails.root.to_s + '/db/DataRefresh_091912.csv') do |row|
            next if row[0] == "LOCATION"
            puts "Updating Playground: " + row[0].to_s
            currpg = Playground.where(:name => row[0].to_s).first
            # puts "Updating from ActiveRecord, playground mapid: " + currpg.mapid.to_s           
            currpg.totplay = row[1]
            currpg.opentopublic = row[2]
            currpg.howtogetthere = row[3]
            currpg.shade = row[4]
            currpg.seating = row[5]
            currpg.restrooms = row[6]
            currpg.drinkingw = row[7]
            currpg.activeplay = row[8]
            currpg.socialplay = row[9]
            currpg.creativeplay = row[10]
            currpg.naturualen = row[11]
            currpg.freeplay = row[12]
            currpg.save
        end
        # Populate new criteriakeys table
        puts "begin seeding criteriakeys table"
        # Totplay values
        Criteriakey.where(:criterianame => 'totplay', :scalevalue => 2).first_or_create(:textvalue => 'Yes', :description => 'Play equipment for toddlers and preschoolers')
        Criteriakey.where(:criterianame => 'totplay', :scalevalue => 1).first_or_create(:textvalue => 'No', :description => 'Play equipment for toddlers and preschoolers')
        # Open To Public Values
        Criteriakey.where(:criterianame => 'opentopublic', :scalevalue => 3).first_or_create(:textvalue => 'Open at all times', :description => 'Open to the public')
        Criteriakey.where(:criterianame => 'opentopublic', :scalevalue => 2).first_or_create(:textvalue => 'Open with some hours of exception', :description => 'Open to the public')
        Criteriakey.where(:criterianame => 'opentopublic', :scalevalue => 1).first_or_create(:textvalue => 'No', :description => 'Open to the public')
        # How to Get there Values
        Criteriakey.where(:criterianame => 'howtogetthere', :scalevalue => 3).first_or_create(:textvalue => 'Auto, public transit, pedestrians', :description => 'How to get there')
        Criteriakey.where(:criterianame => 'howtogetthere', :scalevalue => 2).first_or_create(:textvalue => 'Auto and pedestrians', :description => 'How to get there')
        Criteriakey.where(:criterianame => 'howtogetthere', :scalevalue => 1).first_or_create(:textvalue => 'Pedestrians and limited parking', :description => 'How to get there')
        # Shade values
        Criteriakey.where(:criterianame => 'shade', :scalevalue => 3).first_or_create(:textvalue => 'Plenty', :description => 'Trees or shade structure are on or near playground')
        Criteriakey.where(:criterianame => 'shade', :scalevalue => 2).first_or_create(:textvalue => 'Some', :description => 'Trees or shade structure are on or near playground')
        Criteriakey.where(:criterianame => 'shade', :scalevalue => 1).first_or_create(:textvalue => 'None', :description => 'Trees or shade structure are on or near playground')
        # Seating values
        Criteriakey.where(:criterianame => 'seating', :scalevalue => 3).first_or_create(:textvalue => 'Plenty', :description => 'benches, picnic tables, or other places to sit')
        Criteriakey.where(:criterianame => 'seating', :scalevalue => 2).first_or_create(:textvalue => 'Some', :description => 'benches, picnic tables, or other places to sit')
        Criteriakey.where(:criterianame => 'seating', :scalevalue => 1).first_or_create(:textvalue => 'None', :description => 'benches, picnic tables, or other places to sit')
        # Public Restroom values
        Criteriakey.where(:criterianame => 'restrooms', :scalevalue => 2).first_or_create(:textvalue => 'Yes', :description => 'Onsite or nearby public restrooms')
        Criteriakey.where(:criterianame => 'restrooms', :scalevalue => 1).first_or_create(:textvalue => 'No', :description => 'Onsite or nearby public restrooms')
        # Drinking Water values
        Criteriakey.where(:criterianame => 'drinkingw', :scalevalue => 2).first_or_create(:textvalue => 'Yes', :description => 'Onsite or nearby drinking water')
        Criteriakey.where(:criterianame => 'drinkingw', :scalevalue => 1).first_or_create(:textvalue => 'No', :description => 'Onsite or nearby drinking water')
        # Active Play values
        Criteriakey.where(:criterianame => 'activeplay', :scalevalue => 2).first_or_create(:textvalue => 'Yes', :description => 'Encourages physical activity')
        Criteriakey.where(:criterianame => 'activeplay', :scalevalue => 1).first_or_create(:textvalue => 'No', :description => 'Encourages physical activity')
        # Social Play values
        Criteriakey.where(:criterianame => 'socialplay', :scalevalue => 2).first_or_create(:textvalue => 'Yes', :description => 'Encourages social interaction')
        Criteriakey.where(:criterianame => 'socialplay', :scalevalue => 1).first_or_create(:textvalue => 'No', :description => 'Encourages social interaction')
        # Creative Play values
        Criteriakey.where(:criterianame => 'creativeplay', :scalevalue => 2).first_or_create(:textvalue => 'Yes', :description => 'Encourages learning and creativity')
        Criteriakey.where(:criterianame => 'creativeplay', :scalevalue => 1).first_or_create(:textvalue => 'No', :description => 'Encourages learning and creativity')
        # Natural Environment values
        Criteriakey.where(:criterianame => 'naturualen', :scalevalue => 2).first_or_create(:textvalue => 'Yes', :description => 'Provides for natural play')
        Criteriakey.where(:criterianame => 'naturualen', :scalevalue => 1).first_or_create(:textvalue => 'No', :description => 'Provides for natural play')
        # Free Play values
        Criteriakey.where(:criterianame => 'freeplay', :scalevalue => 2).first_or_create(:textvalue => 'Yes', :description => 'Space for free play')
        Criteriakey.where(:criterianame => 'freeplay', :scalevalue => 1).first_or_create(:textvalue => 'No', :description => 'Space for free play')
        puts "done seeding criteriakeys table"
    end
end