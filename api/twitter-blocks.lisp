(in-package :twitter)
;;
;; Block Methods
;;
;; Block resources
;;    blocks/create
;;    blocks/destroy
;;    blocks/exists
;;    blocks/blocking
;;    blocks/blocking/ids


;;Destroys a friendship to the blocked user if it exists. Returns the blocked user in the requested format when successful.
(define-command blocks/create (:post :twitter-user)
    (twitter-app-uri "blocks/create.json")
    "Blocks the user specified in the ID parameter as the authenticating user. "
    :user_id "The ID of the user for whom to return results for. Helpful for disambiguating when a valid user ID is also a valid screen name."
    :screen_name "The screen name of the user for whom to return results for. Helpful for disambiguating when a valid screen name is also a user ID."
    :include_entities "When set to either true, t or 1, each tweet will include a node called entities")
 
(define-command blocks/destroy (:post :twitter-user)
    (twitter-app-uri "blocks/destroy.json")
    "Un-blocks the user specified in the ID parameter as the authenticating user.  Returns the un-blocked user in the requested format when successful."
    :user_id "The ID of the user for whom to return results for. Helpful for disambiguating when a valid user ID is also a valid screen name."
    :screen_name "The screen name of the user for whom to return results for. Helpful for disambiguating when a valid screen name is also a user ID."
    :include_entities "When set to either true, t or 1, each tweet will include a node called entities")

(define-command blocks/exists (:get :twitter-user)
    (twitter-app-uri "blocks/exists.json")
    "Returns if the authenticating user is blocking a target user."
    :user_id "The ID of the user for whom to return results for. Helpful for disambiguating when a valid user ID is also a valid screen name."
    :screen_name "The screen name of the user for whom to return results for. Helpful for disambiguating when a valid screen name is also a user ID."
    :include_entities "When set to either true, t or 1, each tweet will include a node called entities")

(define-command blocks/blocking (:get (:twitter-user))
    (twitter-app-uri "blocks/blocking.json")
    "Returns an array of user objects that the authenticating user is blocking."
  :page "Specifies the page of results to retrieve."
  :include_entities "When set to either true, t or 1, each tweet will include a node called entities")

(define-command blocks/blocking/ids (:get (:identity))
    (twitter-app-uri "blocks/blocking/ids.json")
    "Returns an array of numeric user ids the authenticating user is blocking.")

 
;;--------------------- end of blocks resources -----------------------------------------------

(define-twitter-method create-block ((screen-name)  &key (user-id nil) (include-entities t)) :blocks/create :screen-name )

(define-twitter-method remove-block ((screen-name)  &key (user-id nil) (include-entities t)) :blocks/destroy :screen-name )

(define-twitter-method is-blocked ((screen-name)  &key (user-id nil) (include-entities t)) :blocks/exists :screen-name )

(define-twitter-method blocks ( () &key (page nil) (include-entities nil)) :blocks/blocking )

(define-twitter-method blocked-user-ids (()) :blocks/blocking/ids)

;;--------------------------------------------------------

(defun is-blocked? (screen-name)
  (handler-case 
      (progn
	(is-blocked screen-name)
	t)
    (error (c)
      (declare (ignore c))
      nil)))