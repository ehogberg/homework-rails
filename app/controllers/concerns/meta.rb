module Meta
    extend ActiveSupport::Concern
   
     def standard_pageable_meta
        standard_meta.merge(page: (params[:page] || 1),
                            per_page: (params[:per_page] || 25))
     end
      
     def standard_meta
        now = Time.now
        
        { ns: "org.homework",
          human_readable_date: now.to_s,
          timestamp: now.to_i }
     end 
end