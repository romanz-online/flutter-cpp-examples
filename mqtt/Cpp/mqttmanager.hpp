#include <memory>

#include <mqtt/async_client.h>

const std::string SERVER_ADDRESS = "tcp://localhost:1883";
const std::string CLIENT_ID = "Temperature";
const std::string TOPIC = "temp";

class callback : public virtual mqtt::callback
{
public:
    using MessageCallback = std::function<void(const std::string &)>;
    callback(MessageCallback onMessageReceived) : onMessageReceived_(onMessageReceived) {}

    void message_arrived(mqtt::const_message_ptr msg) override
    {
        std::string topic = msg->get_topic();
        std::string payload = msg->to_string();
        std::cout << "Topic <" << topic << ">; Payload <-- " << payload << " -->" << std::endl;

        size_t delimiterPos = payload.find('&');
        std::string senderID = payload.substr(0, delimiterPos);

        if (onMessageReceived_ && topic == TOPIC && senderID != CLIENT_ID)
        {
            onMessageReceived_(payload);
        }
    }

    void connected(const std::string &cause) override
    {
        std::cout << cause << std::endl;
    }

    void connection_lost(const std::string &cause) override
    {
        std::cout << cause << std::endl;
    }

private:
    MessageCallback onMessageReceived_;
};

class MqttManager
{
public:
    void init(const std::function<void(const std::string &)> &onMessageReceived)
    {
        client = std::make_unique<mqtt::async_client>(SERVER_ADDRESS, CLIENT_ID);
        cb = std::make_unique<callback>(onMessageReceived);
        client->set_callback(*cb);

        connOpts.set_keep_alive_interval(20);
        connOpts.set_clean_session(true);

        std::cout << "Connecting..." << std::endl;
        client->connect(connOpts)->wait();

        std::cout << "Subscribing to <" << TOPIC << ">" << std::endl;
        client->subscribe(TOPIC, 1)->wait();
    }

    void sendMessage(std::string message)
    {
        std::cout << "Sending message " << CLIENT_ID + "&" + message << std::endl;
        if (client)
        {
            client->publish(mqtt::make_message(TOPIC, CLIENT_ID + "&" + message))->wait();
        }
    }

    void exit()
    {
        if (client)
        {
            client->disconnect()->wait();
        }
    }

private:
    std::unique_ptr<mqtt::async_client> client;
    std::unique_ptr<callback> cb;
    mqtt::connect_options connOpts;
};