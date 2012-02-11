#  Copyright 2011/2012 Dextra Sistemas
#  
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#  
#  http://www.apache.org/licenses/LICENSE-2.0
#  
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

require 'redmine'
require 'dispatcher'

Dispatcher.to_prepare do
  require_dependency 'issues_poll_issue_patch'
  require_dependency 'issues_poll_queries_helper_patch'
  require_dependency 'issues_poll_user_patch'
  require_dependency 'issues_poll_project_patch'
  require_dependency 'issues_poll_hook'
end

Redmine::Plugin.register :redmine_issues_poll do
  name 'Redmine Issues Poll'
  author 'Dextra Sistemas'
  description 'This is a plugin for Redmine to elect issues'
  version '0.0.1'
  url 'https://github.com/dextra/redmine_issues_poll'
  author_url 'http://www.dextra.com.br'
  
  project_module :issues_poll do
    permission :issues_poll_config, :polls => [:index, :set_votes, :set_statuses, :update_votes]
    permission :issues_poll_bet, :polls => [:bet, :cancel_bet]
  end
  
  menu :project_menu, :issues_poll_menu, { :controller => 'polls', :action => 'index' }, :caption => :issue_polls_caption, :after => :activity, :param => :project_id
  
  activity_provider :bets
  
end


