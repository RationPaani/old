module StoresHelper
	def printcat(maincat)
		htmm ||= ""
        maincat.each do |cat|
	       htmm += "<ul>" + "#{link_to cat.name, params.merge(:cat => cat.name)}"
		       
		       if(cat.subcates.first)
		       		htmm += "<li>"
			        htmm += "#{printcat(cat.subcates)}"
			        htmm += "</li>"
			    end
			htmm += "</ul>"
		end
		htmm.html_safe
	end
end