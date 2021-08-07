require 'fox16'
include Fox

require "json"

require "./lib/classes/Race"
require "./lib/classes/Profession"
require "./lib/classes/Character"

require "./pages/maneuvers_page"
require "./pages/skills_page"
require "./pages/statistics_page"
require "./pages/misc_page"
require "./pages/post_cap_page"
require "./pages/loadout_page"
require "./pages/progression_page"

class GS4CharacterManager < FXMainWindow

  def initialize(app)
    character = newCharacter
    super(app, "GS4 Character Generator", :width => 1560, :height => 900)
    add_tab_book(character)
  end

  def create
    super
    show()
  end

  # Creates a new character with default race Human, and default profession Warrior
  def newCharacter
    race = Race.new
    profession = Profession.new
    character = Character.new

    character.setProfession(profession.getProfessionObjectFromDatabase("Warrior"))
    character.setRace(race.getRaceObjectFromDatabase("Human"))

    return character
  end

  # Builds the tabbed interface
  # @param [Object] character Common character object
  def add_tab_book(character)
    tabbook = FXTabBook.new(self, :opts => LAYOUT_FILL)

    stats_tab = FXTabItem.new(tabbook, " Stats ")
    stats_tab.font = FXFont.new(app, "Arial", 16)
    stats_page = FXVerticalFrame.new(tabbook, :opts => FRAME_RAISED | LAYOUT_FILL)

    skills_tab = FXTabItem.new(tabbook, " Skills ")
    skills_tab.font = FXFont.new(app, "Arial", 16)
    skills_page = FXVerticalFrame.new(tabbook, :opts => FRAME_RAISED | LAYOUT_FILL)

    maneuvers_tab = FXTabItem.new(tabbook, " Maneuvers ")
    maneuvers_tab.font = FXFont.new(app, "Arial", 16)
    maneuvers_page = FXVerticalFrame.new(tabbook, :opts => FRAME_RAISED | LAYOUT_FILL)

    post_cap_tab = FXTabItem.new(tabbook, " Post Cap ")
    post_cap_tab.font = FXFont.new(app, "Arial", 16)
    post_cap_page = FXVerticalFrame.new(tabbook, :opts => FRAME_RAISED | LAYOUT_FILL)

    misc_tab = FXTabItem.new(tabbook, " Misc ")
    misc_tab.font = FXFont.new(app, "Arial", 16)
    misc_page = FXVerticalFrame.new(tabbook, :opts => FRAME_RAISED | LAYOUT_FILL)

    loadout_tab = FXTabItem.new(tabbook, " Loadout ")
    loadout_tab.font = FXFont.new(app, "Arial", 16)
    loadout_page = FXVerticalFrame.new(tabbook, :opts => FRAME_RAISED | LAYOUT_FILL)

    progression_tab = FXTabItem.new(tabbook, " Progression ")
    progression_tab.font = FXFont.new(app, "Arial", 16)
    progression_page = FXVerticalFrame.new(tabbook, :opts => FRAME_RAISED | LAYOUT_FILL)

    construct_stats_page(stats_page, character)
    construct_skills_page(skills_page, character)
    construct_maneuvers_page(maneuvers_page)
    construct_post_cap_page(post_cap_page)
    construct_misc_page(misc_page)
    construct_loadout_page(loadout_page)
    construct_progression_page(progression_page)
  end

  # Builds the main stat page Matrix
  # @param [Object] page
  # @param [Object] character
  def construct_stats_page(page, character)
    statistics = StatisticsPage.new(app)
    statistics.show_page(page, character)
    puts character.inspect
  end

  # Stub for Skills page tab
  # @param [Object] page
  # @param [Object] character
  def construct_skills_page(page, character)
    skill = SkillsPage.new(app)
    skill.show_page(page, character)
  end

  # Stub for Maneuvers page tab
  # @param [Object] page
  def construct_maneuvers_page(page)
    maneuvers = ManeuversPage.new(app)
    maneuvers.show_page(page)
  end

  # Stub for Post Cap page tab
  # @param [Object] page
  def construct_post_cap_page(page)
    post_cap = PostCapPage.new(app)
    post_cap.show_page(page)
  end

  # Stub for Misc page tab
  # @param [Object] page
  def construct_misc_page(page)
    misc = MiscPage.new(app)
    misc.show_page(page)
  end

  # Stub for Loadout page Tab
  # @param [Object] page
  def construct_loadout_page(page)
    loadout = LoadoutPage.new(app)
    loadout.show_page(page)
  end

  # Stub for Progression page tab
  # @param [Object] page
  def construct_progression_page(page)
    progression = ProgressionPage.new(app)
    progression.show_page(page)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    GS4CharacterManager.new(app)
    app.create
    app.run
  end
end
