ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }


  controller do
    before_filter :set_tags

    def set_tags
      @tags = current_user.tag_list
    end
  end


  content :title => proc{ I18n.t("active_admin.dashboard") } do
    panel "My Competencies" do
      current_user.fancy_tag_list
    end

    panel "Flagged for Follow-up" do
      "<div class='blank_slate_container loading ajax_flagged_apps' data-tag_list='#{current_user.tag_list}'><span class='blank_slate'>&nbsp;</span></div>".html_safe
    end

    columns do
      column do
        panel "Unreviewed Applications" do
            "<div class='blank_slate_container loading ajax_recent_apps' data-tag_list='#{current_user.tag_list}'><span class='blank_slate'>&nbsp;</span></div>".html_safe
        end
      end

      if current_admin_user
        column do
          panel "Recent Reviews" do
            '<div class="blank_slate_container loading ajax_recent_"><span class="blank_slate">There are no Recent Reviews at this time.</span></div>'.html_safe
            "<div class='blank_slate_container loading ajax_recent_reviews' data-tag_list='#{current_user.tag_list}'><span class='blank_slate'>&nbsp;</span></div>".html_safe
            # if @recent_reviews.any?
            #   ul do
            #     @recent_reviews.each do |rev|
            #       li "#{rev.user.name} reviewed #{link_to(rev.application.name, admin_application_review_path(rev.application, rev))} #{time_ago_in_words(rev.updated_at)} ago".html_safe
            #     end
            #   end
            # else
            #   '<div class="blank_slate_container loading"><span class="blank_slate">There are no Recent Reviews at this time.</span></div>'.html_safe
            # end
          end
        end
      end
    end
  end


end
