$.ajaxSetup({
  statusCode: {
    302: function (response) {
      let redirectUrl = response.getResponseHeader('X-Ajax-Redirect-Url');
      if (redirectUrl) {
        window.location.pathname = redirectUrl;
      }
    }
  }
});