for required_cmd in (brew git nvim tmux); do
    command -v $required_cmd || zsh $DOTFILES/$required_cmd/setup.sh
done

sh $DOTFILES/osx/setup.sh

correct_profile_name=`basename $(ls -rt $DOTFILES/terminal/*.terminal | tail -n 1) | cut -f 1 -d '.'`
current_profile_name=`defaults read com.apple.Terminal "Default Window Settings"` 
[ $correct_profile_name = $current_profile_name ] || zsh $DOTFILES/terminal/setup.sh 

[ $(crontab -l | wc -c) -eq 0 ] || zsh $DOTFILES/cron/setup.sh

[ -L $HOME/.zshrc ] || zsh $DOTFILES/zsh/setup.sh 
