namespace :people do
    
    namespace :file do
        
        desc "Load person records from a textfile."
        task :load, [:file] => :environment do |t,args|
            datafile = args[:file]
            if File.exists?(datafile)
               File.open datafile do |f|
                   errs = []
                   new_people = 0
                   f.each_line do |l|
                        p = Person.new
                        begin
                            p.attributes_from_line(l).save!
                            new_people += 1
                        rescue Exception
                            errs << p
                        end
                   end
                   puts "New person records added: #{new_people}"
                   puts "Total exception count: #{errs.count}."
               end
            else
                puts "No such file: #{datafile}."
            end
        end
        
    end
    
    namespace :admin do
       
       desc "Purge the person table."
       task :purge => :environment do
           Person.delete_all
           puts "Person table purged"
       end
       
    end
    
end