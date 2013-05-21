require 'spec_helper'

describe "watch gets dropped off from the end of a member rotation" do
  it "sends member an email letting them know the watch was received" 
  it "sets the current transit record as the previous record" 
  it "creates an storage record and sets it as the watch's current status" 
  it "sets the end_time of the transit record and the start_time of the storage record" 
  it "lets the admin know they need to assign a bin number" 
  it "lets the admin know the watch needs to be cleaned" 
  it "asks the admin if the watch needs servicing" 
  it "selects a new watch to send to the member" 
  it "creates a transit record for the new watch for shipping to the member" 
  it "creates a rotation record for the new watch for the next member" 
  it "prompts the admin to schedule the pickup for the new watch" 
end


describe "admin creates a service record" do
  it "creates a new transit record for shipping to vendor" 
  it "creates a new service record" 
  it "prompts the admin to schedule the pickup" 
end

describe "admin updates service record to completed status" do
  it " prompts the admin to schedule the pickup" 
end

describe "watch gets dropped off from servicing" do
  it "makes the current record the previous one" 
  it "creates an storage record and sets it as the watch's current status" 
  it "lets the admin know they need to assign a bin number" 
  it "marks the watch as available" 
end

describe "admin schedules a pickup" do
  it "properly notifies the transit service" 
  it "adds an est_start_time and est_end_time to the transit record" 
  it "adds an est_start_time and est_end_time to the next record" 
end

describe "watch is picked up from elevenjames" do
  it "sets the current transit record as the previous record" 
  it "sets the next record as the current status" 
  it "sets the start_time on the transit record and the end_time on the storage record" 
end

describe "watch arrives at member's address" do
  it "sets the start_time on the rotation record and the end_time on the transit record"
  it "updates the est_end_time on the rotation record"
  it "creates a transit record from the member's address to elevenjames" 
  it "prompts the admin to schedule the pickup from the member's address" 
end

describe "watch is picked up from member's address" do
  it "sets the end_time on the rotation record and the start_time on the transit record"
  it "updates the est_end_date on the transit record"
end
