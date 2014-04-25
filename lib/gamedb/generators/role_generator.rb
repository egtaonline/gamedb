class RoleGenerator
  def self.build(role_name_array)
    value_string = role_name_array.map { |role| "('#{role}')" }.join(', ')
    DB.fetch("INSERT INTO roles (role_name) VALUES #{value_string}" \
             ' RETURNING role_id, role_name').all
  end
end
