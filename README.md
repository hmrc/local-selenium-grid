# Local Selenium Grid

Selenium Grid via selenium-server standalone

## Pros/Cons vs Docker Selenium Grid

* Good, because there is no need to setup port mappings if trying to address services in browsers via localhost (that are running on the host if using docker)
* Good, because it's likely more performant by default for more people than running browsers in docker
* Bad, because if you use chrome plugins then you can't run headless
* Bad, because the brower popping up and closing repeatedly can interrupt other work

## Usage

### Prerequisites

* bash (how I've encapsulated downloading and running the selenium server jar)
* curl (how I'm downloading the selenium server jar)
* java (how we run the selenium-server jar)
* ability to run browsers locally, you don't need any local browsers or drivers, they're all downloaded as needed by selenium (though which versions are supported are pinned in browser-versions.toml)

### Start

> [!WARNING]
> Ensure that nothing is already running on http://localhost:4444
>
> If you already have selenium grid running there, the script won't fail to start so it may look like you've successfully started it, when actually you're still interacting with the already running selenium grid service

Then, start as follows:

```shell
./start.sh
```

Leave it running in a terminal, and close it stop it when you're finished

Navigate to http://localhost:4444 to view the Selenium Grid dashboard

### Verify it's working

> [!IMPORTANT]
> The first time you run a test with a browser, it may be slower than the subsequent runs because selenium has to download the browser and driver binaries. You will see the browsers open and close as the tests run.

Ensure that selenium grid is started, and in a new terminal:

1. `git clone https://github.com/hmrc/platform-test-example-ui-journey-tests.git`
2. `cd platform-test-example-ui-journey-tests`
3. [Follow the instructions for starting required services](https://github.com/hmrc/platform-test-example-ui-journey-tests?tab=readme-ov-file#services)
3. `./run-tests.sh chrome`
4. `./run-tests.sh edge`
5. `./run-tests.sh firefox`

### Run browsers in headless mode

Running a browser headless means that the browser window isn't visible when the tests are running
 
The way that the ui-test-runner library automatially sets up browsers to run accessibility checks of pages visited during testing relies on a browser plugin

The original (default) headless mode most browsers implement doesn't allow the use of browser plugins

So unfortunately we weren't able to run tests using a headless browser

However, [Chrome has now introduced a new headless mode](https://developer.chrome.com/docs/chromium/new-headless#new_headless_in_selenium-webdriver) that enables (among other things) the use of browser plugins

At the moment it's not possible when using the ui-test-runner library to configure it to open the browser using the new headless mode

As a temporary work around, (thanks to a contribution by [Lewis Mitchell](https://github.com/LewisMitchell) 🙌) you can [checkout and start selenium grid from this branch](https://github.com/hmrc/local-selenium-grid/pull/2/files) which configures all chrome browsers opened by local-selenium-grid to use the new headless mode

### Debug

If it fails to start, problems will be logged to `./selenium-server.log`

