const seoDatamapper = require('../../models/seo');

const seoController = {

    async renderRobotTxt(req, res) {
        // Dynamic response
        const robotsText = await seoDatamapper.getRobotsText();
        // console.log('----------------------------------------------------------');
        // console.log('robotsText from DB: ' + robotsText);
        // console.log('type de robotsText: ' + typeof robotsText);
        res.type('text/plain');
        res.send(robotsText.file_text);
    },
    async renderSiteMapXml(req, res) {
        // Dynamic response avoiding problems with heroku when pushing codes
        const siteMapText = await seoDatamapper.getSiteMapText();
        res.type('text/xml');
        res.send(siteMapText.file_text);
    },
};

module.exports = seoController;
