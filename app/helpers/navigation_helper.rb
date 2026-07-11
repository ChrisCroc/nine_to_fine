module NavigationHelper
  def nav_destinations
    [
      { label: "Closet", path: garments_path, icon: "fa-shirt", controller: "garments" },
      { label: "Looks", path: outfits_path, icon: "fa-layer-group", controller: "outfits" },
      { label: "Profile", path: user_path(current_user), icon: "fa-user", controller: "users" }
    ]
  end

  def nav_active?(controller)
    controller_name == controller
  end
end
