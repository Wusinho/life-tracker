module HousesHelper

  def link_to_add_user(user, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id


    fields =
      f.fields_for(association, new_object, child_index: id) do |builder|
        # `association.to_s.singularize + "_fields"` ends up evaluating to `address_fields`
        # The render function will then look for `views/people/_address_fields.html.erb`
        # The render function also needs to be passed the value of 'builder', because `views/people/_address_fields.html.erb` needs this to render the form tags.
        render(association.to_s.singularize + "_fields", f: builder)
      end
    link_to(
      name,
      "#",
      class: "add_fields",
      data: {
        id: id,
        fields: fields.gsub("\n", ""),
      },
      )
  end

end
