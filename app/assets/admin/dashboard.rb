ActiveAdmin.register_page "Dashboard" do
    menu priority: 1, label: "Dashboard"
  
    content title: "Dashboard" do
      columns do
        column do
          panel "Users" do
            User.count
          end
        end
  
        column do
          panel "Products" do
            Product.count
          end
        end
  
        column do
          panel "Orders" do
            Order.count
          end
        end
      end
    end
  end
  