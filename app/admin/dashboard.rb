ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    panel "Flagged Applications" do
      ul do
        Application.flagged(10).each do |app|
          li app.name
        end
      end
    end

    columns do
      column do
        panel "Recent Applications" do
          ul do
            Application.recent(10).each do |app|
              li app.name
            end
          end
        end
      end
      column do
        panel "Recent Reviews" do
          ul do
            Review.recent(10).each do |act|
              li act.inspect
            end
          end
        end
      end
    end
  end

end
