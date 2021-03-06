ActiveAdmin.register Vendor do

  action_item only: :show do
    link_to "All Time Slots", admin_vendor_time_slots_path(vendor)
  end

  action_item only: :show do
    link_to "Create Time Slot", new_admin_vendor_time_slot_path(vendor)
  end

  action_item only: :show do
    link_to "Create Truck", new_admin_vendor_truck_path(vendor)
  end

  show do
    panel "Time Slots" do
      table_for(vendor.time_slots) do |t|
        t.column :start_at
        t.column :finish_at
        t.column :location
        t.column(:availabity) do |time_slot|
          status_tag(time_slot.available? ? "Open" : "Reserved")
        end

        t.column(:actions) do |time_slot|
          [ link_to("View", admin_vendor_time_slot_path(vendor_id: vendor.id, id: time_slot)), 
            link_to("Edit", edit_admin_vendor_time_slot_path(vendor_id: vendor.id, id: time_slot)), 
            link_to("Delete", admin_vendor_time_slot_path(vendor_id: vendor.id, id: time_slot.id), method: :delete) ].join(", ").html_safe
        end

      end
    end
    active_admin_comments
  end

  sidebar :vendor_attributes, only: :show do
    attributes_table_for resource do
      row :name
      row :cuisine
      row :website
      row :contact_name
      row :phone
      row :email
      row :business_license_number
    end
  end

  sidebar :vendor_trucks, only: :show do
    ul do
      vendor.trucks.map {|truck| li { link_to truck.license_plate, admin_vendor_truck_path(truck) } }.join("")
    end
  end

end
