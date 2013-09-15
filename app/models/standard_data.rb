class StandardData


  def self.enhance(standard_data={}, options={})

    standard_data = standard_data.present? ? standard_data : {}
    standard_data[:data] = standard_data[:data] || {}
    standard_data[:order] = standard_data[:order] || []
    # standard_data[:active_ids] = standard_data[:active_ids] || []
    # standard_data[:active_indices] = standard_data[:active_indices] || []

    active_ids = options[:active_ids] || nil


    puts active_ids.inspect
    if active_ids.present?
      new_active_ids = []
      new_active_indices = []
      active_ids.each_with_index do |id, index|
        if standard_data[:data].has_key?(id)
          new_active_ids.push(id)
          new_active_indices.push(index)
        end
      end
      standard_data.merge!({active_ids: new_active_ids, active_indices: new_active_indices})
    end

  end




end