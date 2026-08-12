/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
class CfgDisabledCommands
{
  class CREATEUNIT
  {
    class SYNTAX1
    {
      targets[] = {0,0,0};
      args[] = {{"STRING"},{"ARRAY"}};
    };

    class SYNTAX2
    {
      targets[] = {0,0,0};
      args[] = {{"GROUP"},{"ARRAY"}};
    };
  };

    class VEHICLES
    {
        targets[] = {1,0,1};
    };
    /*
    class ALLPLAYERS
    {
        targets[] = {1,0,1};
    };

    class ALLUNITS
    {
        targets[] = {1,0,1};
    };

    class ALLMISSIONOBJECTS
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{},{"STRING"}};
        };
    };*/

    class ALLGROUPS
    {
        targets[] = {1,0,1};
    };

    /*
    class MARKERTEXT
  {
    class SYNTAX1
    {
      targets[] = {0,0,0};
      args[] = {{},{"STRING"}};
    };
  };
    */

  class SETMARKERTEXT
  {
    class SYNTAX1
    {
      targets[] = {0,0,0};
      args[] = {{"STRING"},{"STRING"}};
    };
  };

    class CREATEMARKER
  {
    class SYNTAX1
    {
      targets[] = {0,0,0};
      args[] = {{},{"ARRAY"}};
    };
  };
};
