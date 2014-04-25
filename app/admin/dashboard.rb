ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  # one downside to activeadmin: mixing controller/views
  flagged = Application.flagged
  recent_reviews = Review.recent
  recent_apps = Application.recent

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    panel "Flagged for Follow-up (#{flagged.size} total)" do
      if flagged.any?
        ul do
          flagged.each do |app|
            li link_to app.name, admin_application_path(app)
          end
        end
      else
        '<div class="blank_slate_container"><span class="blank_slate">There are no Flagged Applications at this time.</span></div>'.html_safe
      end
    end

    columns do
      column do
        panel "Unreviewed Applications (#{Application.all.size} total)" do
          if recent_apps.any?
            ul do
              recent_apps.each do |app|
                li link_to app.name, admin_application_path(app)
              end
            end
          else
            '<div class="blank_slate_container"><span class="blank_slate">There are no Recent Applications at this time.</span></div>'.html_safe
          end
        end
      end

      if current_admin_user
        column do
          panel "Recent Reviews (#{Review.all.size} total)" do
            if recent_reviews.any?
              ul do
                recent_reviews.each do |rev|
                  li "#{rev.user.name} reviewed #{link_to(rev.application.name, admin_application_review_path(rev.application, rev))} #{time_ago_in_words(rev.updated_at)} ago".html_safe
                end
              end
            else
              '<div class="blank_slate_container"><span class="blank_slate">There are no Recent Reviews at this time.</span></div>'.html_safe
            end
          end
        end
      end
    end
  end


end
