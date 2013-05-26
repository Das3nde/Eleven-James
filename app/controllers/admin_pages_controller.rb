class AdminPagesController < ApplicationController
  layout "static"
  before_filter :set_variables
  
  def model
    
  end
  
  def set_variables
    @brands  = ["A. Lange",
    "Audemars Piguet",
    "Bell & Ross",
    "Blancpain",
    "Burberry",
    "Cartier",
    "Chopard",
    "Girard-Perregaux",
    "Glashutte Original",
    "Hublot",
    "IWC",
    "Jaeger",
    "Omega",
    "Panerai",
    "Patek Philippe",
    "Piaget",
    "Roger Dubuis",
    "Rolex",
    "Ulysse Nardin",
    "Vacheron Constantin",
    "Zenith"]
    
    @tiers= ["Artisan",
      "Master Craftsman",
      "Technician"]
    
    @diameter = ["39.7 mm",
      "41 mm",
      "42 mm",
      "43.5 mm",
      "44 mm",
      "47 mm",
      ]
    @status = [
      "Full Inventory",
      "Available",
      "Transit to Member",
      "Transit to 11James",
      "Service"
      ]
  end
end
