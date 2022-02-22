module.exports = (

    (actorObject) => {
        // Have in capital letters fist letter of name and full surname
        actorObject.surname = actorObject.surname.toUpperCase();
        actorObject.name = actorObject.name.charAt(0).toUpperCase()
            + actorObject.name.slice(1).toLowerCase();
        actorObject.email = actorObject.email.toLowerCase();
        return actorObject;
    }
);
