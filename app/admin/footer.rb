module ActiveAdmin
  module Views
    class Footer < Component

      def build
        super :id => "footer"
        div.footer do
          str = "#{link_to(image_tag('18f.jpg'), "http://18f.gsa.gov")}" +
                "<div class='who'>Brought to you by <a href='http://18f.gsa.gov'>18F</a></div>" +
                "<div class='tagline'>It's Hire-EZier!</div>" +
                "<div class='sync-info'>Last sync with Salesforce: " +
                Import.last.created_at.to_formatted_s(:long) + "</div><br clear='both' />"
          str.html_safe
        end
      end

    end
  end
end