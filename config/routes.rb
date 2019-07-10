Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  constraints Clearance::Constraints::SignedIn.new do
    get 'cluster', to: 'cluster#index'
    post 'cluster/restart', to: 'cluster#restart'
    post 'cluster/stop', to: 'cluster#stop'

    get 'users', to: 'users#index'
    post 'users', to: 'users#create'
    post 'users/modify', to: 'users#modify'
    post 'users/delete', to: 'users#remove'

    get 'ssh', to: 'keys#index'
    post 'ssh', to: 'keys#create'
    post 'ssh/delete', to: 'keys#delete'

    get 'network', to: 'network#index'
    post 'network/edit', to: 'network#edit'
    post 'firewall/add-ssh', to: 'network#add_ssh_service'
    post 'firewall/remove-ssh', to: 'network#remove_ssh_service'

    post 'vpn/start', to: 'vpn#start'
    post 'vpn/stop', to: 'vpn#stop'
    post 'vpn/restart', to: 'vpn#restart'

    get 'console', to: 'console#index'

    get 'assets', to: 'assets#index'
    get 'assets/:name', to: 'assets#single_asset'

    delete  '/logout',  to: 'sessions#destroy'

    match '/login' => redirect('/'), via: :get

    root 'cluster#index'
  end

  constraints Clearance::Constraints::SignedOut.new do
    get     '/login',   to: 'sessions#new'
    post    '/login',   to: 'sessions#create'

    match '*path', to: 'sessions#new', via: :get

    root 'sessions#new'
  end
end
