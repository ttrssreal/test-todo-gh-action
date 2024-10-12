{
# [user]
# 	email = jess@jessie.cafe
# 	name = Jess
# 	signingkey = BA3350686C918606
#
# [commit]
# 	gpgsign = true
#
# [url "ssh://git@github.com/"]
# 	insteadOf = https://github.com/
# [gpg]
# 	program = gpg
# [core]
# 	excludesfile = /home/jess/.config/git/ignore

  programs.git = {
    enable = true;
    userEmail = "jess@jessie.cafe";
    userName = "Jess";
    signing = {
      key = "BA3350686C918606";
      signByDefault = true;
    };
    extraConfig = {
      url."ssh://git@github.com/".insteadOf = "https://github.com/";
    };
    ignores = [
      ".direnv"
      ".envrc"
      ".env"
      ".local"
    ];
  };
}
