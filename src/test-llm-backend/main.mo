import LLM "mo:llm";


actor {
type data = {
  raport : Text;
  model1 : Text;
  model2 : Text;
  model3 : Text;
  };

 /// public func prompt(prompt : Text) : async Text {
 //   await LLM.prompt(#Llama3_1_8B, prompt);
 // };
 public query func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };

  private func chat(messages : [LLM.ChatMessage]) : async Text {
    await LLM.chat(#Llama3_1_8B, messages);
  };
  
  public func bit(message : Text) : async data{
    let messages1 = [
      {
        role = #system_;
        content = "bez żadnego zbendego komentarza : napisz ile spuł głosek jest w tekscie";
      },
      {
        role = #user;
        content = message;
      }
    ];
    
    let response1 = await chat(messages1);
    let messages2 = [
      {
        role = #system_;
        content = "bez żadnego zbendego komentarza : napisz ile samo głosek jest w tekscie";
      },
      {
        role = #user;
        content = message;
      }
    ];
    
    let response2 = await chat(messages2);
    let messages3 = [
      {
        role = #system_;
        content = "bez żadnego zbendego komentarza : napisz ile liter jest w tekscie";
      },
      {
        role = #user;
        content = message;
      }
    ];
    
    let response3 = await chat(messages3);
    let response4 = [
      {
        role = #system_;
        content = "przygotuj raport z przekazanych tobie informacji";
      },
      {
        role = #user;
        content = response3;
      },
      {
        role = #user;
        content = response2;
      },
      {
        role = #user;
        content = response1;
      }
    ];
    
    let raport = await chat(response4);

    

    let repost = {raport = raport; model1 = response1; model2 = response2; model3 = response3};
    return repost;
};
};